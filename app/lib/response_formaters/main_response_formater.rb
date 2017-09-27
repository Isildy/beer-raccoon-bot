class MainResponseFormater

  WEB_BUTTON_TYPE = 'web_url'.freeze
  JSON_PLUGIN_BUTTON_TYPE = 'json_plugin_url'.freeze

  def gallery_template(elements)
    [{
       attachment: {
         type: 'template',
         payload: {
           template_type: 'generic',
           elements: elements
         }
       }
     }]
  end

  def list_template(elements, buttons=nil)
    [{
      attachment: {
        type: 'template',
        payload: {
          template_type: 'list',
          top_element_style: 'large',
          elements: elements,
          buttons: buttons
        }
      }
    }]
  end

  def image_template(url)
    {
      attachment: {
        type: 'image',
        payload: { url: url }
      }
    }
  end

  def text_template(body)
    { text: body }
  end

  def text_with_buttons_templates(text_body, buttons)
    {
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: text_body,
          buttons: buttons
        }
      }
    }
  end


  def show_block_button(block_name, title)
    {
      type: 'show_block',
      block_name: block_name,
      title: title
    }
  end

  def response_with_attributes(main_body, attributes)
    { set_attributes: attributes, messages: main_body }
  end

  def button_template(url, title)
    {
      type: 'json_plugin_url',
      url:  url,
      title: title
    }
  end

  def text_with_quick_reply_template(text, buttons)
    {
        text: text,
        quick_replies: buttons
    }
  end

  def main_block_name_template(block_name, body)
    { block_name: block_name, body: body }
  end
end