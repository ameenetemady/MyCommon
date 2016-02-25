require 'gnuplot'

local plotUtil = {}

do
  function plotUtil.plot2d(teX, teY, taParam)

  gnuplot.raw('set terminal png')
  gnuplot.raw('set output "' .. taParam.strFigureFilename .. '"')
  gnuplot.raw('set xtics out nomirror; set ytics out nomirror; set border 3;set key reverse; set grid')
  gnuplot.raw('set xtics 0.25')
  gnuplot.raw('set ytics 0.25')

  gnuplot.xlabel(taParam.xlabel)
  gnuplot.ylabel(taParam.ylabel)
  gnuplot.title(taParam.title)
--  gnuplot.axis({0,1.05,0,1.05})
--  gnuplot.movelegend('left', 'top')

  gnuplot.raw('set style circle radius graph 0.005')
  gnuplot.plot({'.', teX:squeeze(), teY:squeeze(), 'circles fs transparent solid 0.6 noborder lc rgb "red"'})

    end

   return plotUtil
end
