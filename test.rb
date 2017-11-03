require "selenium-webdriver"

# If the requested test environment is not registered with the hub
# or busy, allow enough time for the Gridlastic auto scaling
# functionality to launch a node with the requested environment.
client = Selenium::WebDriver::Remote::Http::Default.new
client.timeout = 600 # seconds.

username = "TESTINIUMUSER"
key = "TESTINIUMPASS"
gridHost = "http://hub.testinium.io/wd/hub"
caps = Selenium::WebDriver::Remote::Capabilities.chrome(
    :version               => "46",
    :platform              => "WIN8_1",
    :recordsVideo          => true,
    :takesScreenshot       => true,
    :browserName           => "firefox",
    :key                   => username+":"+key
)
driver = Selenium::WebDriver.for(:remote, :url => gridHost, :http_client => client, :desired_capabilities => caps)
driver.manage.timeouts.implicit_wait = 60
driver.manage.window.maximize
begin

  driver.navigate.to "https://www.amazon.com/"
  searchElement = driver.find_element(:id, 'twotabsearchtextbox')
  searchElement.send_keys "Superman Comics"
  searchElement.submit
ensure
  driver.quit
end