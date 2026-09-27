puts "Čištění databáze..."
Reservation.destroy_all
Room.destroy_all

puts "Vytváření místností..."
small_room = Room.create!(name: "Alpha Meeting Room", capacity: 2)
large_room = Room.create!(name: "Beta Conference Hall", capacity: 5)

tomorrow = Time.current.tomorrow.beginning_of_day

puts "Vytváření rezervací..."

Reservation.create!(room: small_room, guest_name: "Alice", start_date: tomorrow + 10.hours, end_date: tomorrow + 12.hours)
Reservation.create!(room: small_room, guest_name: "Bob", start_date: tomorrow + 10.hours, end_date: tomorrow + 12.hours)

Reservation.create!(room: small_room, guest_name: "Charlie", start_date: tomorrow + 13.hours, end_date: tomorrow + 14.hours)
Reservation.create!(room: small_room, guest_name: "Dave", start_date: tomorrow + 14.hours, end_date: tomorrow + 15.hours)

3.times do |i|
  Reservation.create!(
    room: large_room,
    guest_name: "Team Member #{i + 1}",
    start_date: tomorrow + 15.hours,
    end_date: tomorrow + 17.hours
  )
end

puts "========================================================="
puts "✅ Databáze byla úspěšně naplněna!"
puts "📅 Datum pro testování: #{tomorrow.to_date}"
puts "---------------------------------------------------------"
puts "🧪 TESTOVACÍ SCÉNÁŘE (vyzkoušejte v prohlížeči):"
puts ""
puts "1. FAIL: Zkuste zarezervovat '#{small_room.name}' od 10:30 do 11:30."
puts "   -> Mělo by to vyhodit chybu (obě místa už mají obsazená Alice a Bob)."
puts ""
puts "2. SUCCESS: Zkuste zarezervovat '#{small_room.name}' od 13:30 do 14:30."
puts "   -> Mělo by to projít úspěšně! (Charlie odchází ve 14:00, Dave přichází ve 14:00. Algoritmus pozná, že je 1 místo volné)."
puts ""
puts "3. SUCCESS: Zkuste zarezervovat '#{large_room.name}' od 15:00 do 16:00."
puts "   -> Mělo by to projít úspěšně (jsou obsazena pouze 3 z 5 míst)."
puts "========================================================="