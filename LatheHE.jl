module LatheHE
    using Lathe.stats, Lathe.preprocess, Lathe.models
    using Hone, Compose
    function BestFit(plt, divisions = 5, color = :lightblue, weight = 2)
        frame = plt.get_frame()
        x = plt.x
        y = plt.y
        divisionamount = 1 / divisions
        lower = 75
        totaldivisions = 0
        arrays = []
        while totaldivisions < 1
            top, lower = SortSplit(y,divisionamount)
            append!(arrays,top)
            totaldivisions += divisionamount
        end
        xmeans = [a = mean(a) for a in arrays]
        # Y -- 
        lower = 75
        totaldivisions = 0
        arrays = []
        while totaldivisions < 1
            top, lower = SortSplit(y,divisionamount)
            append!(arrays,top)
            totaldivisions += divisionamount
        end
        ymeans = [a = mean(a) for a in arrays]
        topy = maximum(y)
        topx = maximum(x)
        pairs = []
        first = true
        for (i,w) in zip(xmeans,ymeans)
            if first == true
                x = 0
                first = false
            else
                x = (i / topx * frame.width)
            end
            y = (w / topy * frame.height)
            pair = Tuple([x,y])
            push!(pairs,pair)
        end
        pairs = Array{Tuple{Float64,Real},1}(pairs)
        lin = Line(pairs,color,weight)
        expression = string("(context(),",lin.update(:foo),")")
        tt = Hone.transfertype(expression)
        frame.add(tt)
    end
end
