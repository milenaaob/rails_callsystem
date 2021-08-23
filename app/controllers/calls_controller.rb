class CallsController < ApplicationController
  before_action :set_call, only: %i[ show edit update destroy ]

  # GET /calls or /calls.json
  def index
    @calls = Call.all
    @plans = Plan.all
  end

  # GET /calls/1 or /calls/1.json
  def show
     id = @call.plan_id
     @plan = Plan.find(id)
     @plan = @plan.name
  end

  # GET /calls/new
  def new
    @call = Call.new
  end

  # GET /calls/1/edit
  def edit
  end

  # POST /calls or /calls.json
  def create

    fees = fees(params[:call][:origin], params[:call][:destiny])
    puts fees
    puts fees
    puts fees
    valuewithplan = valuewithplan(fees, params[:call][:minuts].to_i, params[:call][:plan_id].to_i)
    valuewithoutplan = valuewithoutplan(fees, params[:call][:minuts].to_i)

    @call = Call.new(
      origin: params[:call][:origin],
      destiny: params[:call][:destiny],
      minuts: params[:call][:minuts],
      valuewithplan: valuewithplan,
      valuewithoutplan: valuewithoutplan,
      plan_id: params[:call][:plan_id]

    )

    respond_to do |format|
      if @call.save
        format.html { redirect_to @call, notice: "Call was successfully created." }
        format.json { render :show, status: :created, location: @call }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end

  def fees origin, destiny

    if origin == '011'
      if destiny == '016'
        fees = 1.9
      else
        if destiny == '017'
          fees = 1.7
        else
          fees = 0.9
        end
      end
    else
      if origin == '016'
        fees = 2.9
      else
        if origin == '017'
          fees = 2.7
        else
          fees = 1.9
        end
      end
    end
    return fees
  end

  def valuewithplan fees, minuts, plan
    if minuts <= plan
      value = 0.00
    else
      if plan == 30
        additionals = minuts - 30
        value = ((additionals * fees) + ((additionals * fees)*0.10))
      else
        if plan == 60
          additionals = minuts - 60
          value = additionals * fees + (additionals * fees)*0.10
        else
          additionals = minuts - 120
          value = additionals * fees + (additionals * fees)*0.10
        end
      end
    end
    return value

  end

  def valuewithoutplan fees, minuts

    value = fees * minuts;
    return value
  end

  # PATCH/PUT /calls/1 or /calls/1.json
  def update
    respond_to do |format|
      if @call.update(call_params)
        format.html { redirect_to @call, notice: "Call was successfully updated." }
        format.json { render :show, status: :ok, location: @call }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calls/1 or /calls/1.json
  def destroy
    @call.destroy
    respond_to do |format|
      format.html { redirect_to calls_url, notice: "Call was successfully destroyed." }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_call
      @call = Call.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def call_params
      params.require(:call).permit(:origin, :destiny, :minuts)
    end
end
