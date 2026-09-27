class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new(room_id: params[:room_id])
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to room_path(@reservation.room), notice: "Reservation created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      redirect_to room_path(@reservation.room), notice: "Reservation updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:room_id, :guest_name, :start_date, :end_date)
  end
end
