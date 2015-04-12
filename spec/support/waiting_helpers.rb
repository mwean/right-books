module WaitingHelpers
  def wait_until(time = Capybara.default_wait_time, &block)
    Timeout.timeout(time) do
      loop do
        break if block.call
        sleep 0.01
      end
    end
  end
end

RSpec.configure { |config| config.include(WaitingHelpers, type: :feature) }
