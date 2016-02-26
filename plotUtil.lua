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

  function plotUtil.hist(taTeData, nBins, min, max)
--    gnuplot.hist(teData, 10)
  
      nBins = nBins or 20
      min = min or 0
      max = max or 0.25
      local teX = torch.linspace(min, max, nBins)

      local taPlot = {}
      local strFormat = "~"
      for k, teData in pairs(taTeData) do
        local teBins = torch.histc(teData, nBins, 0, max)
        local taCurr = { k, teX, teBins, strFormat }
        table.insert(taPlot, taCurr)
      end

      gnuplot.plot(taPlot)

     
  end

  return plotUtil
end
