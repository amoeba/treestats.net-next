Sequel.migration do
  up do
    File.open("db/dump.sql").read.each_line do |line|
      puts line
      run line
    end
  end
end
