module ChildPostsHelper
  def render_with_hashtags(hashbody)
    # hashbodyがnilまたは空の場合、空の文字列を返す
    return '' if hashbody.blank?

    # hashbodyが存在する場合、ハッシュタグをリンクに変換
    hashbody.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) do |word|
      link_to word, "/child_post/hashtag/#{word.delete("#")}", data: { "turbolinks" => false }
    end.html_safe
  end
end
