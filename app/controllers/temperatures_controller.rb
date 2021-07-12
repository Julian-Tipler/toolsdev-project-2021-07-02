class TemperaturesController < ApplicationController
  before_action :set_temperature, only: %i[ show edit update destroy ]

  # GET /temperatures or /temperatures.json
  def index
    @entries = Temperature.order('datetime desc').last(792)
    
    # temperatures converted to epoch time
    @temperatures = @entries[72...792].map{ |entry| 
      [entry.datetime.to_time.to_i * 1000,entry.temperature]
    }
    @temperatures.reverse!()
    puts @temperatures

    @predictions = @entries[0...72].map{ |entry| 
      [entry.datetime.to_time.to_i * 1000,entry.temperature]
    }
    @predictions.reverse!()
    puts @predictions

    # temperatures grouped by 3's and converted to epoch time

    x = 72
    currentArray = []
    @highs = []
    @lows = []
    while x<792
      currentArray.push(@entries[x].temperature,@entries[x+1].temperature,@entries[x+2].temperature)
      @highs.push([@entries[x].datetime.to_time.to_i * 1000,currentArray.max()])
      @lows.push([@entries[x].datetime.to_time.to_i * 1000,currentArray.min()])
      currentArray = []
      x+=3
    end
    @highs.reverse!()
    @lows.reverse!()
  end

  # GET /temperatures/1 or /temperatures/1.json
  def show
  end

  # GET /temperatures/new
  def new
    @temperature = Temperature.new
  end

  # GET /temperatures/1/edit
  def edit
  end

  # POST /temperatures or /temperatures.json
  def create
    @temperature = Temperature.new(temperature_params)

    respond_to do |format|
      if @temperature.save
        format.html { redirect_to @temperature, notice: "Temperature was successfully created." }
        format.json { render :show, status: :created, location: @temperature }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @temperature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /temperatures/1 or /temperatures/1.json
  def update
    respond_to do |format|
      if @temperature.update(temperature_params)
        format.html { redirect_to @temperature, notice: "Temperature was successfully updated." }
        format.json { render :show, status: :ok, location: @temperature }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @temperature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /temperatures/1 or /temperatures/1.json
  def destroy
    @temperature.destroy
    respond_to do |format|
      format.html { redirect_to temperatures_url, notice: "Temperature was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temperature
      @temperature = Temperature.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def temperature_params
      params.require(:temperature).permit(:datetime, :temperature)
    end
end
