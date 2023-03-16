class LessonContentImporter
  attr_reader :lesson, :content
  private :lesson, :content

  def initialize(lesson)
    @lesson = lesson
    @content = lesson.content || lesson.build_content
  end

  def self.for(lesson)
    new(lesson).import
  end

  def self.import_all
    total = Lesson.count

    Rails.logger.info 'Importing lesson content...'

    Lesson.all.each_with_index do |lesson, i|
      Rails.logger.info "Importing #{i + 1}/#{total}: #{lesson.title}"
      self.for(lesson)
    end

    Rails.logger.info 'Lesson content import complete.'
  end

  def import
    content.update!(body: content_converted_to_html) if content_needs_updated?
  rescue Octokit::Error => e
    log_error(e.message)
  end

  private

  def content_needs_updated?
    content.body != content_converted_to_html
  end

  def content_converted_to_html
    @content_converted_to_html ||= MarkdownConverter.new(decoded_content).as_html
  end

  def decoded_content
    Base64.decode64(github_response[:content]).force_encoding('UTF-8')
  end

  def github_response
    Octokit.contents('grassroot-software/grassroot_curriculum', path: lesson.github_path)
  end

  def log_error(message)
    Rails.logger.error "Failed to import '#{lesson.title}' message: #{message}"
    false
  end
end
