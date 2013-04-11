# FAQ

## How do I create a new layout?

To create a new layout, you need to save it as a template in the /layouts/ path.

Step my step instructions:

### 1. Chose 'templates' from the admin area:

![Create a template - step 1](images/create_a_template_step_1.png)

### 2. Click 'New template':

![Create a template - step 2](images/create_a_template_step_2.png)

### 3. Add the template body and settings:

![Create a template - step 3](images/create_a_template_step_3.png)

### 4. Click 'Create template':

![Create a template - step 4](images/create_a_template_step_4.png)



## How do I use a specific layout for a page?

To use a specific layout for a page, you need to specify its name in the settings.

Step my step instructions:

Assume you have the page foo.textile, and you want it to use the layout 'my_layout':

### 1. Go to the page and edit it:

![Edit a page - step 1](images/go_to_the_page_and_edit_it_step_1.PNG)

![Edit a page - step 2](images/go_to_the_page_and_edit_it_step_2.PNG)

### 2. Change the layout to 'my_layout'

![Change the layout - step 1](images/change_the_layout_step_1.PNG)


## How do I use layouts from the database?

You can follow the steps in:

  * How do I create a new layout?
  * How do I use a specific layout for a page?

Please note following things:

You need to be using version 1.0.3.pre or greater.

You need to include the template resolver in the application controller to do this:

```
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include Ecm::Cms::ControllerExtensions::TemplateResolver
  ...
end
```