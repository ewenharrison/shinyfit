# Shinyfit: Fully-featured multivariable regression on your browser via Shiny

<!-- wp:paragraph -->
<p>Many of our projects involve getting doctors, nurses, and medical students to collect data on the patients they are looking after. We want to involve many of them in data analysis, without the requirement for coding experience or access to statistical software. To achieve this we have built Shinyfit, a shiny app for linear, logistic, and Cox PH regression. </p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li>Aim: allow access to model fitting without requirement for statistical software or coding experience.</li><li>Audience: Those sharing datasets in context of collaborative research or teaching.</li><li>Hosting requirements: Basic R coding skills including <a href="https://www.tidyverse.org/"><code>tidyverse</code></a> to prepare dataset (5-10 minutes).</li><li>Deployment: Any shiny platform, <a href="http://www.shinyapps.io/">shinyapps.io</a>, <a href="https://www.rstudio.com/products/shiny/shiny-server/">ShinyServer</a>, <a href="https://www.rstudio.com/products/connect/">RStudio Connect</a> etc. </li></ul>
<!-- /wp:list -->

<!-- wp:paragraph -->
<p><code>shinyfit</code> uses our <a href="http://finalfit.org"><code>finalfit</code></a> package.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>Features</h2>
<!-- /wp:heading -->

<!-- wp:list -->
<ul><li>Univariable, multivariable and mixed effects linear, logistic, and Cox Proportional Hazards regression via a web browser.</li><li>Intuitive model building with option to include a reduced model and common metrics.</li><li>Coefficient, odds ratio, hazard ratio plots.</li><li>Cross tabulation across multiple variables with statistical comparisons.</li><li>Subset data by any included factor.</li><li>Dataset inspection functions.</li><li>Export tables to Word for publication or as a CSV for further analysis/plotting.</li><li>Easy to deploy with your own data.</li></ul>
<!-- /wp:list -->

<!-- wp:heading -->
<h2>Examples</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p><a href="https://argoshare.is.ed.ac.uk/shinyfit_colon/">argoshare.is.ed.ac.uk/shinyfit_colon</a><br><a href="https://argoshare.is.ed.ac.uk/shinyfit_melanoma">argoshare.is.ed.ac.uk/shinyfit_melanoma</a></p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>Code</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p><a href="http://github.com/ewenharrison/shinyfit">github.com/ewenharrison/shinyfit</a></p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>Screenshots</h2>
<!-- /wp:heading -->

<!-- wp:image {"id":1114} -->
<figure class="wp-block-image"><img src="http://www.datasurg.net/wp-content/uploads/2018/12/shinyfit_table-1024x313.png" alt="" class="wp-image-1114"/><figcaption>Linear, logistic or CPH regression tables<br></figcaption></figure>
<!-- /wp:image -->

<!-- wp:image {"id":1115} -->
<figure class="wp-block-image"><img src="http://www.datasurg.net/wp-content/uploads/2018/12/shinyfit_plot-1024x659.png" alt="" class="wp-image-1115"/><figcaption>Coefficient, odds ratio or hazard ratio plots</figcaption></figure>
<!-- /wp:image -->

<!-- wp:image {"id":1116} -->
<figure class="wp-block-image"><img src="http://www.datasurg.net/wp-content/uploads/2018/12/shinyfit_crosstabs-1024x315.png" alt="" class="wp-image-1116"/><figcaption>Crosstabs</figcaption></figure>
<!-- /wp:image -->

<!-- wp:image {"id":1117} -->
<figure class="wp-block-image"><img src="http://www.datasurg.net/wp-content/uploads/2018/12/shinyfit_glimpse-1024x348.png" alt="" class="wp-image-1117"/><figcaption>Inspect dataset with <code>ff_glimpse</code></figcaption></figure>
<!-- /wp:image -->

<!-- wp:heading -->
<h2>Use your data</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>To use your own data, clone or download app from <a href="https://github.com/ewenharrison/shinyfit">github</a>.</p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li></li><li>Edit <code>0_prep.R</code> to create a shinyfit_data object. </li><li>Test the app, usually within RStudio.</li><li>Deploy to your shiny hosting platform of choice. </li><li>Ensure you have permission to share the data</li></ul>
<!-- /wp:list -->

<!-- wp:paragraph -->
<p>Editing <code>0_prep.R</code> is straightforward and takes about 5 mins. The main purpose is to create human-readable menu items and allows sorting of variables into any categories, such as <code>outcome</code> and <code>explanatory</code>. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Errors in <code>shinyfit</code> are usually related to the underlying dataset, e.g.</p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li>Variables not appropriately specified as numerics or factors. </li><li>A particular factor level is empty, thus regression function (<code>lm</code>, <code>glm</code>, <code>coxph</code> etc.) gives error.</li><li>A variable with >2 factor levels is used as an outcome/dependent. This is not supported.</li><li>Use <code>Glimpse</code> tabs to check data when any error occurs.</li></ul>
<!-- /wp:list -->

<!-- wp:paragraph -->
<p>It is fully mobile compliant, including datatables.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>There will be bugs. Please report <a href="https://github.com/ewenharrison/shinyfit/issues">here</a>. </p>
<!-- /wp:paragraph -->
