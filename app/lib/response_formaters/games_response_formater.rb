class GamesResponseFormater < MainResponseFormater

  def result_title_template
    { text: I18n.t('result.title') }
  end

  def result_gallery_template
    {
        attachment: {
            type: 'template',
            payload: {
                template_type: 'generic',
                elements: [
                    {
                        title: I18n.t('result.gallery_title', name: user.first_name, answers_correct: answers_correct, answers_passed: answers_passed_ids.size),
                        subtitle: I18n.t('result.gallery_subtitle'),
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
        text: I18n.t('result.quick_reply.title'),
        quick_replies: [
            {
                title: I18n.t('result.quick_reply.play_button_title'),
                block_names: [I18n.t('result.quick_reply.play_button_block')]
            },
            {
                title: I18n.t('result.quick_reply.event_button_title'),
                block_names: [I18n.t('result.quick_reply.event_button_block')]
            },
            {
                title: I18n.t('result.quick_reply.menu_button_title'),
                block_names: [I18n.t('result.quick_reply.menu_button_block')]
            }
        ]
    }
  end

end
