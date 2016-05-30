require 'gnuplot'

local plotUtil = {}

do
  function plotUtil.plot2d(teX, teY, taParam)

    local id = math.random(10000)
    gnuplot.figure(id)

    if taParam.strFigureFilename ~= nil then
      gnuplot.raw('set terminal png')
      gnuplot.raw('set output "' .. taParam.strFigureFilename .. '"')
    end

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
    gnuplot.plotflush()
  end

  function plotUtil.hist(taTeData, taParam)
      taParam = taParam or {}

      nBins = taParam.nBins or 20
      min = taParam.min or 0
      max = taParam.max or 0.25

      local teX = torch.linspace(min, max, nBins)

      local taPlot = {}
      local strFormat = "~"
      for k, teData in pairs(taTeData) do
        local teBins = torch.histc(teData, nBins, 0, max)
        local taCurr = { k, teX, teBins, strFormat }
        table.insert(taPlot, taCurr)
      end


    gnuplot.closeall()
    gnuplot.figure(2)
    if taParam.strFigureFilename ~= nil then
--      gnuplot.raw('set terminal pdf')
      gnuplot.raw('set output "' .. taParam.strFigureFilename .. '"')
    end

    gnuplot.title(taParam.title)
    gnuplot.plot(taPlot)

    gnuplot.closeall()
--    gnuplot.plotflush()


  end

  return plotUtil
end
