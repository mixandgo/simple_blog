require 'spec_helper'

feature 'Markdowns' do

  background do
    markdown_body = %{
# H1 title
## H2 title
### H3 title

```ruby
def method
  return "Hello World"
end
```

```css
.standard-class {
  font-weight: bold;
}
```
}
    create_a_blog_post(:title => 'Blog post title',
                       :body => markdown_body)
    visit_show_page_for('Blog Post Title')
  end

  scenario 'I should see the markdown headers transformed' do
    expect(page).to have_css("h1", :text => "H1 title")
    expect(page).to have_css("h2", :text => "H2 title")
    expect(page).to have_css("h3", :text => "H3 title")
  end

  scenario 'I should see the ruby code highlighted' do
    expect(page).to have_css(".ruby")
  end

  scenario 'I should see the ruby method definition wrapped in right class' do
    expect(page).to have_css("span.k", :text => "def")
  end

  scenario 'I should see the css code highlighted' do
    expect(page).to have_css(".css")
  end

  scenario 'I should see the css class wrapped in the right class' do
    expect(page).to have_css("span.nc", :text => ".standard-class")
  end

end
