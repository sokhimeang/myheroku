module ScheduleHelper
  def student_total search
    Subject.find_by(id: search).students.count
  end

  def create_vertices subjects
    blocks = {}
    subjects.each do |subject|
      if subject.students.count.positive?
        array = []
        subject.students.each do |student|
          student.subjects.each do |s|
            array = array << s.id unless array.include? s.id
          end
        end
        blocks = blocks.merge(subject.id => array)
      end
    end
    blocks
  end

  def create_group list_vertices
    vertices = list_vertices.clone
    blocks = []
    while vertices.empty? == false
      vertice_max = vertices.max_by{|_k, v| v.length}
      vertice_group = [] << [vertice_max[0], student_total(vertice_max[0])]
      list_adjacent = [] | vertice_max[1]
      list_no_adjacent = vertices.clone
      list_adjacent.each do |k|
        list_no_adjacent.delete(k)
      end
      while list_no_adjacent.empty? == false
        vertice_max = list_no_adjacent.max_by{|_k, v| v.length}
        vertice_group = vertice_group << [vertice_max[0],
          student_total(vertice_max[0])]
        list_adjacent |= vertice_max[1]
        list_adjacent.each do |k|
          list_no_adjacent.delete(k)
        end
      end
      vertice_group.each do |id, _total|
        vertices.delete(id)
      end
      blocks = blocks << vertice_group.sort_by{|_id, total| total}
    end
    blocks
  end

  def total_volume array
    volume = 0
    array.each do |a|
      volume += a[1]
    end
    volume
  end

  def create_list_room rooms
    list_room = []
    rooms.each do |room|
      list_room = list_room << [room.id, room.volume]
    end
    list_room
  end

  def create_schedule blocks
    day = blocks[:start_day].to_date + (blocks[:session] / 4).days
    day = day.strftime("%d/%m/%Y")
    session_day = blocks[:session] % 4 + 1
    subject = Subject.find_by id: blocks[:subject_id]
    room = Room.find_by id: blocks[:room_id]
    schedule = Schedule.create(code_subject: subject.code,
      name_subject: subject.name, times_exam: subject.times_exam,
        room_code: room.code, room_name: room.name, day: day,
          session: session_day, group: blocks[:group])
    index_s = blocks[:index]
    index_e = blocks[:index] + blocks[:total]
    subject.students[index_s...index_e].each do |student|
      schedule.add_user student
    end
  end

  def scheduling rooms_exam, list, start_day
    list_group = list.to_a
    list_room = create_list_room rooms_exam
    session = 0
    rooms = []
    list_group.each do |g|
      rooms = list_room.clone
      g.each do |subject|
        group = 0
        count = 0
        while subject[1].positive?

          if subject[1] <= total_volume(rooms)
            length = rooms.length
            rooms.each.with_index(1) do |room, index|
              break if subject[1] <= 0

              if subject[1] <= room[1]
                group += 1
                create_schedule(subject_id: subject[0], room_id: room[0],
                                 group: group, index: count, total: subject[1],
                                  session: session, start_day: start_day)
                count += subject[1]
                subject[1] = 0
                rooms.delete(room)
              elsif index >= length
                subject[1] = subject[1] - room[1]
                group += 1
                create_schedule(subject_id: subject[0], room_id: room[0],
                                 group: group, index: count, total: room[1],
                                  session: session, start_day: start_day)
                count += room[1]
                rooms.delete(room)
              end
            end
          else
            session += 1
            rooms = list_room.clone
          end
        end
      end
      session += 1
    end
  end
end
