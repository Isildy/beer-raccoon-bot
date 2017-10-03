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
                        subtitle: subtitle,
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

  def result_quick_reply_template
    {
        text: 'текст перед кнопками',
        quick_replies: [
            {
                title: 'Some Button',
                block_names: ['Start game']
            },
            {
                title: 'Some Button',
                block_names: ['Start game']
            },
            {
                title: 'Some Button',
                block_names: ['Start game']
            }
        ]
    }
  end

end
