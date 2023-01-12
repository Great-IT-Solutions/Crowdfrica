module CapybaraSessionExtensions
  def has_highlighted_menu?(menu_item)
    has_selector?('nav ul li', class: 'active', text: menu_item)
  end

  def has_table_columns?(*rows)
    has_exact_table?('thead', rows)
  end

  def has_table_rows?(*rows)
    has_exact_table?('tbody', rows)
  end

  def has_exact_table?(selector, arr) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    within selector do
      arr.each_with_index do |row, row_idx|
        row.each_with_index do |expected_text, cell_idx|
          xpath = "tr[#{row_idx + 1}]/*[not (contains(@class, 'hidden'))][#{cell_idx + 1}]"
          elem = find(:xpath, xpath)

          if expected_text == '*'
            # ignore
          elsif elem.text.strip.gsub(/(\n*\s{2,})/, ' ') != expected_text.to_s.strip
            message = "Expected '#{expected_text.to_s.strip}' but got '#{elem.text.strip}' for element '#{xpath}'"
            raise RSpec::Expectations::ExpectationNotMetError, message
          end
        end
      end

      # check number of rows are as expected
      arr.empty? ? has_no_xpath?('tr') : has_xpath?('tr', count: arr.size)
    end
  end
end
Capybara::Session.include CapybaraSessionExtensions
