# Async Document create and processing workflow
class CreateDocument
  attr_reader :current_user, :params, :document

  def initialize(params)
    @params = params
    build
  end

  def call
    saved = @document.save
    queue_process if saved
    saved
  end

  private

  def build
    @document = Document.new(@params)
  end

  def queue_process
    ProcessDocumentJob.perform_later(@document)
  end
end
