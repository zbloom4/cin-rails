object false
node (:success) { true }
node (:info) { 'Appointments' }
child :data do
  child @client do
  	attributes :id, :user_id, :first, :last, :created_at
  	child @client.appointments.each do
      attributes :id, :note, :created_at
      child @location do
      	attributes :id, :latitude, :longitude
      end
    end
  end
end