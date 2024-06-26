class WordReader

  def read_from_file(file_name)
    return nil if !File.exist?(file_name)

    lines = File.readlines(file_name, encoding: "UTF-8")
    lines.sample.chomp
  end
end
