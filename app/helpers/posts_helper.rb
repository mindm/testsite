module PostsHelper

  def wrap(content)
    sanitize(raw(word_array = content.split().map{ |s| word_wrap(s) }.join(' ')), tags: 'wbr')
  end

  private

    def word_wrap(word, max_width = 30)
      break_tag = "<wbr>"
      (word.length < max_width) ? word : word.scan(/.{1,#{max_width}}/).join(break_tag)
    end
    
end