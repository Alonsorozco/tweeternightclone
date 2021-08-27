module TweetsHelper

    def hashtag(content)
        format_content = content.split(" ")
        tag = []
        format_content.each do |p|
            if p.start_with?("#")
                p = link_to p, controller: 'tweets', q: p
            end
            tag.push(p)
        end
        raw tag.join(" ")
    end
    

end
