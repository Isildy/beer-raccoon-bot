class GamesResponseFormater < MainResponseFormater

  attr_accessor :user_name, :answers_correct, :answers_passed_ids, :subtitle

  def initialize(params = {})
    params.each do |name, value|
      send("#{name}=", value)
    end
  end

  def result_title_template
    { text: I18n.t('game.result_title') }
  end

  def result_gallery_template
    {
      attachment: {
        type: 'template',
        payload: {
          template_type: 'generic',
          elements: [
            {
              title: I18n.t('game.result_gallery_title', name: user_name, answers_correct: answers_correct, answers_passed: answers_passed_ids.size),
              image_url: 'https://www.askideas.com/media/12/I-Dont-Know-How-But-It-Will-Funny-Beer-Saying.jpg',
              buttons: [
                {
                  type: 'element_share'
                }
              ]
            }
          ]
        }
      }
    }
  end

  def result_quick_reply_template(reult_text)
    {
      text: reult_text,
      quick_replies: [
        {
          title: 'Пройти за ново',
          block_names: ['Start game']
        }
      ]
    }
  end
end
