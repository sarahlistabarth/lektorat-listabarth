-- shortcode that provides a nicely formatted 'LaTeX' string
-- function bla1()
-- if quarto.doc.isFormat("html") then
--     return pandoc.Math('InlineMath', "\\LaTeX")
-- else 
--   return pandoc.Span('LaTeX')
-- end
-- end

return {
  ["acro"] = function(args)
    local my_abbreviation = pandoc.utils.stringify(args[1])
    
  -- detect PDF    
    if quarto.doc.isFormat("pdf") then
      return pandoc.RawInline(
         "tex",
         '\\acro{', my_abbreviation, "}"
         )

    else
      return pandoc.RawInline(
        "html",
        my_abbreviation
      ) 
    end
  end
}
