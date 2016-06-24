require 'gnuplot'

local plotUtil = {}

do
  function plotUtil.plot2d(teX, teY, taParam, teX2, teY2)
    local id = math.random(10000)
    gnuplot.figure(id)

    if taParam.strFigureFilename ~= nil then
      gnuplot.raw('set terminal png')
      gnuplot.raw('set output "' .. taParam.strFigureFilename .. '"')
    end

    gnuplot.raw('set xtics out nomirror; set ytics out nomirror; set border 3;set key reverse; set grid')
--    gnuplot.raw('set xtics 0.25')
--    gnuplot.raw('set ytics 0.25')

    gnuplot.xlabel(taParam.xlabel)
    gnuplot.ylabel(taParam.ylabel)
    gnuplot.title(taParam.title)


    if teX2 == nil then
      gnuplot.raw('set style circle radius graph 0.005')
      gnuplot.plot({'Target', teX:squeeze(), teY:squeeze(), 'circles fs transparent solid noborder '})
    else
      gnuplot.raw('set style circle radius graph 0.015')
      gnuplot.plot({'Target', teX:squeeze(), teY:squeeze(), 'circles fs transparent solid 0.5 lc rgb "blue"'},
                   {'Pred', teX2:squeeze(), teY2:squeeze(), 'points pt 2 ps 0.4 lc rgb "red"'})

    end
    gnuplot.closeall()
  end

  function plotUtil.plot3d(teX, teY, teZ, taParam)
    local id = math.random(10000)
    gnuplot.figure(id)

    if taParam.strFigureFilename ~= nil then
      gnuplot.raw('set terminal png')
      gnuplot.raw('set output "' .. taParam.strFigureFilename .. '"')
    end

    gnuplot.raw('set xtics out nomirror; set ytics out nomirror; set border 3;set key reverse; set grid')

    gnuplot.xlabel(taParam.xlabel)
    gnuplot.ylabel(taParam.ylabel)
    gnuplot.zlabel(taParam.zlabel)
    gnuplot.title(taParam.title)

    gnuplot.scatter3(teX:squeeze(), teY:squeeze(), teZ:squeeze())
    gnuplot.closeall()

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
