@web
Feature: Selenium steps

  This feature provides examples on how to use some of the most common steps for selenium. All feature files that include
  steps for testing web pages using selenium (such as this one) must include the "@web" annotation at the beginning of the file.
  This is necessary, since it signals the library that it should bootstrap selenium and other important components.

  Scenario: Testing direct steps and new locators
    Given I go to 'http://${DEMO_SITE_HOST}/index.html@p=49.html'
    And I wait until element with 'id:name_3_firstname' is present
    Then I type 'Jose' on the element with 'id:name_3_firstname'
    And I type 'Fernandez' on the element with 'id:name_3_lastname' index '0'
    And I click on the element with 'name:radio_4[]' index '0'
    And I click on the element with 'name:checkbox_5[]' index '1'
    And I click on the element with 'name:checkbox_5[]' index '2'
    And I scroll down until the element with 'name:pie_submit' is visible
    And I scroll up until the element with 'id:name_3_firstname' is visible
    And I scroll down until the element with 'name:description' is visible
    And I save 'GingerSpec user' in variable 'NAME'
    And I type on the element with 'name:description' the text:
    """
      Hello ${NAME}!.

      You can use this step to type large pieces of text into a text area,
      which is typical when typing an address for example. Notice that you
      can also use variables inside the text ;)
    """
    And I scroll down until the element with 'name:pie_submit' is visible
    When I click on the element with 'name:pie_submit'
    Then I wait '3' seconds


  Scenario: Finding a text anywhere on the page
    Given My app is running in '${DEMO_SITE_HOST}'
    When I browse to '/'
    And I wait '1' seconds
    Then this text exists:
    """
    <h1 class="entry-title">Home</h1>
    """
    #log Testing variable replacement in text exists step
    Then I save 'Home' in variable 'var'
    Then this text exists:
    """
    <h1 class="entry-title">${var}</h1>
    """
    And I wait '1' seconds


  @ignore @toocomplex
  Scenario: Test a file picker. The file must be visible from the file system where the browser is being executed
    Given My app is running in '${DEMO_SITE_HOST}'
    When I browse to '/registration'
    When '1' elements exists with 'id:profile_pic_10'
    Then I assign the file in 'schemas/empty.json' to the element on index '0'
    And I wait '3' seconds


  Scenario: Test send keys function
    Given My app is running in '${DEMO_SITE_HOST}'
    When I browse to '/registration'
    When '1' elements exists with 'id:name_3_firstname'
    Then I type 'testUser' on the element on index '0'
    Then I send 'ENTER' on the element on index '0'
    And I wait '1' seconds
    When '7' elements exists with 'class:legend_txt'
    And I wait '2' seconds


  @ignore @toocomplex
  Scenario: Dummy scenario with HTTPS
    Given My app is running in 'es.dummy-test.com'
    When I securely browse to '/'


  Scenario: Navigating directly to a web page
    Given I go to 'http://${DEMO_SITE_HOST}/registration'
    And we are in page 'http://${DEMO_SITE_HOST}/registration/'
    And the current url contains the text 'registration'


  Scenario: Interacting with different elements in a form
    Given My app is running in '${DEMO_SITE_HOST}'
    When I browse to '/registration'
    Then in less than '20' seconds, checking each '2' seconds, '1' elements exists with 'id:name_3_firstname'
    When '1' elements exists with 'xpath://*[@id="name_3_lastname"]'
    And I click on the element on index '0'
    When '1' elements exists with 'id:phone_9'
    Then the element on index '0' has 'id' as 'phone_9'
    And I type '555-555' on the element on index '0'
    And I clear the content on text input at index '0'
    When '1' elements exists with 'xpath://*[@id="pie_register"]/li[6]/div/label'
    And the element on index '0' has 'Phone Number' as text


  Scenario: Checking if AT LEAST n elements exists
    Given My app is running in '${DEMO_SITE_HOST}'
    When I browse to '/'
    Then at least '1' elements exists with 'class:detail-entry'
    And I click on the element on index '0'
    When I browse to '/'
    Then at least '2' elements exists with 'class:detail-entry'
    When I browse to '/'
    Then at least '3' elements exists with 'class:detail-entry'


  Scenario: Saving element property in variable
    Given My app is running in '${DEMO_SITE_HOST}'
    When I browse to '/'
    Then at least '1' elements exists with 'xpath://*[@id="post-9"]/div/div[1]/div/p[1]/a'
    Then I save the value of the property 'href' of the element in index '0' in variable 'VAR'
    And '${VAR}' contains '/wp-content/uploads/2014/08/pattern-14.png'
    Then '1' elements exists with 'id:menu-item-146'
    Then I save the value of the property 'class' of the element in index '0' in variable 'VAR2'
    And '${VAR2}' matches 'menu-item menu-item-type-post_type menu-item-object-page menu-item-146'


  Scenario: Testing radio buttons and checkboxes
    Given My app is running in '${DEMO_SITE_HOST}'
    When I browse to '/registration'
    When '3' elements exists with 'name:radio_4[]'
    And the element on index '0' IS NOT selected
    Then I click on the element on index '0'
    And the element on index '0' IS selected
    Then I click on the element on index '1'
    And the element on index '0' IS NOT selected
    When '3' elements exists with 'name:checkbox_5[]'
    And the element on index '0' IS NOT selected
    And the element on index '1' IS NOT selected
    Then I click on the element on index '0'
    And the element on index '0' IS selected
    Then I click on the element on index '1'
    And the element on index '1' IS selected


  @ignore @toocomplex
  Scenario: Testing an element state (enable/disabled). Ignored because depends on an external web page
    Given My app is running in 'www.w3schools.com'
    When I browse to '/jsref/tryit.asp?filename=tryjsref_pushbutton_disabled2'
    Then I switch to iframe with 'id:iframeResult'
    When '1' elements exists with 'xpath://*[@id="myBtn"]'
    And the element on index '0' IS enabled
    When '1' elements exists with 'xpath:/html/body/button[2]'
    When I click on the element on index '0'
    When '1' elements exists with 'xpath://*[@id="myBtn"]'
    And the element on index '0' IS NOT enabled


  @ignore @toocomplex
  Scenario: Testing an element display property. Ignored because depends on an external web page
    Given My app is running in 'www.w3schools.com'
    When I browse to '/howto/tryit.asp?filename=tryhow_js_toggle_hide_show'
    Then I switch to iframe with 'id:iframeResult'
    When '1' elements exists with 'id:myDIV'
    And the element on index '0' IS displayed
    When '1' elements exists with 'xpath:/html/body/button'
    When I click on the element on index '0'
    When '1' elements exists with 'id:myDIV'
    And the element on index '0' IS NOT displayed


  Scenario: Testing if a specific webelement has an especific value in an especific css property
    Given My app is running in '${DEMO_SITE_HOST}'
    When I browse to '/registration'
    And I wait '1' seconds
    And '3' elements exists with 'css:input[name='radio_4[]']'
    Then the element in index '1' has 'radio_4[]' in property 'name'


  Scenario: Creating an alert using Javascript
    Given My app is running in '${DEMO_SITE_HOST}'
    When I browse to '/'
    And I wait '1' seconds
    And I execute 'alert("This is an alert!")' as javascript
    And I wait '3' seconds
    And I check every '1' seconds for at least '5' seconds until an alert appears
    And I accept the alert


  Scenario: Executing a javascript to click on an element and to get info of the page
    Given My app is running in '${DEMO_SITE_HOST}'
    When I browse to '/'
    And I wait '1' seconds
    And '1' elements exists with 'xpath://*[@id="menu-item-158"]/a'
    And I execute 'arguments[0].click();' as javascript on the element on index '0'
    And I wait '3' seconds
    And I execute 'return document.URL;' as javascript and save the result in the environment variable 'PAGE'
    And '${PAGE}' contains 'index.html'
