object false
node (:success) { true }
node (:info) { 'Appointment selected!' }
child :data do
  child @client do
    attributes :id, :user_id, :first, :last, :created_at
    child @appointment do
      attributes :id, :note, :created_at
      child @locations.each do
      	attributes :id, :longitude, :latitude, :created_at
      end
    end
  end
end