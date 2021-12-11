class OperationsController < ApplicationController
  before_action :set_wallet
  before_action :set_operation, only: %i[ show edit update destroy ]
  before_action :set_breadcrumbs, except: [:cambiar_stop_loss, :calcular_riesgo_refill]


  # GET /operations or /operations.json
  def index
    @breadcrumbs += [
      {link: wallet_operations_path(@wallet), text: 'Operations', enable: true}
    ]
    @operations = @wallet.operations
  end

  # GET /operations/1 or /operations/1.json
  def show
    @breadcrumbs += [
      {link: wallet_operations_path(@wallet), text: 'Operations', enable: true},
      {link: '#', text: @operation._id, enable: false}
    ]
  end

  # GET /operations/new
  def new
    @operation = Operation.new
  end

  # GET /operations/1/edit
  def edit
  end

  # POST /operations or /operations.json
  def create
    @operation = Operation.new(operation_params)
    @operation.wallet_id = @wallet.id
    respond_to do |format|
      if @operation.save
        format.html { redirect_to [@wallet, @operation], notice: "Operation was successfully created." }
        format.json { render :show, status: :created, location: @operation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operations/1 or /operations/1.json
  def update
    respond_to do |format|
      if @operation.update(operation_params)
        format.html { redirect_to [@wallet, @operation], notice: "Operation was successfully updated." }
        format.json { render :show, status: :ok, location: @operation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operations/1 or /operations/1.json
  def destroy
    @operation.destroy
    respond_to do |format|
      format.html { redirect_to wallet_operations_path(@wallet), notice: "Operation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_wallet
      @wallet = Wallet.find(params[:wallet_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_operation
      @operation = Operation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def operation_params
      params.require(:operation).permit(:activo, :broker, :fecha_entrada, :precio_de_compra, :unidades_compradas, :stop_loss, :posicion, :status, :comentario, :wallet_id)
    end

    def set_breadcrumbs
      @breadcrumbs = [
        {link: root_path, text: 'Wallets', enable: true},
        {link: @wallet, text: @wallet.nombre, enable: true},
      ]
    end
end
