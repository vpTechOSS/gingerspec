package com.privalia.qa.ATests;

import com.privalia.qa.data.BrowsersDataProvider;
import com.privalia.qa.utils.BaseGTest;
import io.cucumber.testng.CucumberOptions;
import org.testng.annotations.Factory;

@CucumberOptions(
        features = {"src/test/resources/features/seleniumPoolingSteps.feature"},
        glue = "com.privalia.qa.specs")
public class SeleniumPoolingStepsIT extends BaseGTest {

    @Factory(dataProviderClass = BrowsersDataProvider.class, dataProvider = "availableUniqueBrowsers")
    public SeleniumPoolingStepsIT(String browser) {
        this.browser = browser;
    }

}
