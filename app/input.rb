# TODO: errors everywhere!!!!
# TODO: Output https://github.com/tj/terminal-table
# TODO: no results page
class Input
  MODELS_NAMES = %w[users tickets organizations] # TODO: extract
  DEFAULTS = { field: '_id', query: '11' }

  def initialize(prompt = TTY::Prompt.new)
    @prompt = prompt
  end

  def model
    @model ||= prompt.select("Select the file to search", MODELS_NAMES, cycle: true)
  end

  def field
    @field ||= prompt.ask("Enter your search term", default: DEFAULTS[:field])
  end

  def query
    @query ||= prompt.ask("Enter your search value", default: DEFAULTS[:query])
  end

  private

  attr_reader :prompt
end
