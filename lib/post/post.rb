class Post < Sequent::AggregateRoot
  def initialize(command)
    super(command.aggregate_id)
    apply PostAdded
    apply PostAuthorChanged, author: command.author
    apply PostTitleChanged, title: command.title
    apply PostContentChanged, content: command.content
  end

  def publish(publication_date)
    fail PostAlreadyPublishedError if @publication_date.any?
    apply PostPublished, publication_date: publication_date
  end

  on PostAdded do
  end

  on PostAuthorChanged do |event|
    @author = event.author
  end

  on PostTitleChanged do |event|
    @title = event.title
  end

  on PostContentChanged do |event|
    @content = event.content
  end
end
