function[] = CompareMeans(SelectedN,Which,Info, Path,Exps, Selection, MeansOnly, XLim,PalettePoints, PaletteMeans, varargin)
    Heatmaps = 3000;
    try
        YLimits = varargin{1};
        Heatmaps = varargin{2};
    end
    %try
    %Selection = '';
    if MeansOnly == 1
        Fig1 = figure('PaperSize',[30 50],'PaperUnits','inches','resize','on', 'visible','on');
        Fig1.Renderer='Painters';
    else
        Fig2 = figure('PaperSize',[30 50],'PaperUnits','inches','resize','on', 'visible','on');
        Fig2.Renderer='Painters';
    end
    
    Fig3 = figure('PaperSize',[17 50],'PaperUnits','inches','resize','on', 'visible','on');
    Fig3.Renderer='Painters';

    ToSave = [Path,char(join(SelectedN,'_vs_'))];
        FigH = figure('PaperUnits','inches','PaperSize',[4*length(SelectedN) 10],'Units','points','resize','on', 'visible','on','DefaultAxesFontSize', 7);
        FigH.Renderer='Painters';
    
    if Which == 3
        Index = find(cellfun(@(x) strcmp(x,SelectedN{1}),table2array(Exps(:,1)))==1)';
        SelectedN = table2cell(Exps(Index,3));
    end
    for i = 1:length(SelectedN)
        Index = find(cellfun(@(x) strcmp(x,SelectedN{i}),table2array(Exps(:,Which)))==1)';
        PropertiesMerged = table();
        TimeScaleMerged = [];
        NormMerged = [];
        OnOffMerged = [];

        %try
        for x = 1:size(Index,2)
            %try
            Experiment = [Exps.Nickname{Index(x)},' ',num2str(Exps.Rep(Index(x)))]
            PathToSave = [Info.Path{Index(x)},Info.File{Index(x)},...
            Info.Name{Index(x)},Info.File{Index(x)}]; 
            load([PathToSave,'_Data.mat']);
            try
                MaxF = Data.MaxF;
                MedFilt = Data.MedFilt;
                OnOff = Data.OnOff;
                Properties = Data.Properties;
                Baseline = Data.Baseline;
                TimeScale = Data.TimeScale;
            catch
                MaxF = Data.Data.MaxF;
                MedFilt = Data.Data.MedFilt;
                OnOff = Data.Data.OnOff;
                Properties = Data.Data.Properties;
                Baseline = Data.Data.Baseline;
                TimeScale = Data.Data.TimeScale;
            end
            if strcmp(Selection,'') == 1
                Selected = [Properties.Type ~= 'BG'];
            else
                Selected = Properties.Type ~= 'EarlyOnly' & Properties.Region == Selection;
            end
            
            Bits = Info.Bits(Index(x));
            TimeRes = Info.TimeRes(Index(x));
            nc14 = Info.nc14(Index(x));
            Delay = Info.Delay(Index(x));
            SplitEarly = 15;
           
            SplitEarlyF = max([SplitEarly*60./TimeRes+nc14-Delay,1]);
            minOn = 5;
            OnOff = CleanOnOff(OnOff,minOn);
            [OnOff] = CleanNaNs(MedFilt,OnOff, minOn*2);
            Norm = ((MaxF-Baseline').*Baseline(1)./Baseline').*(2.^(12-Bits));
            %Norm = (MaxF-Baseline').*OnOff.*Baseline(1)./Baseline'.*(2.^(12-Bits));
            Norm(Norm==0) = NaN;
            Limits = [0, 90];
%             [BurstNum,BurstLength,BurstPeriod,BurstPeak,BurstMax,OffTimeAll,BurstSize] = CountBursts(Norm,OnOff, Selected,minOn,SplitEarlyF,TimeRes);
%             PlotSelected(Selected, TimeScale,Baseline,MaxF,MedFilt,OnOff,Properties,BurstPeak,TimeRes,Bits,nc14, Delay,Limits,[Path,'/',Info.File{Index(x)},'_selected_',Selection,'.ps']);
%             
            MaxF = MaxF(:,Selected);
            MedFilt = MedFilt(:,Selected);
            OnOff = OnOff(:,Selected);
            Properties = Properties(Selected,:);
            Properties.NormAP = (Properties.AP_position-min(Properties.AP_position))./max(Properties.AP_position);
            Norm = Norm(:,Selected);
            OnOff(isnan(MaxF)) = NaN;

            [NormMerged,~,~] = MergeFMatrix(Norm,NormMerged,Properties,PropertiesMerged,TimeScale,TimeScaleMerged,TimeRes);     
            [OnOffMerged,PropertiesMerged,TimeScaleMerged] = MergeFMatrix(OnOff,OnOffMerged,Properties,PropertiesMerged,TimeScale,TimeScaleMerged,TimeRes);     

        end
        
       [NormMerged,~,~] = MergeFMatrix([NaN],NormMerged,table(0),PropertiesMerged,[0],TimeScaleMerged,TimeRes);
       [OnOffMerged,PropertiesMerged,TimeScaleMerged] = MergeFMatrix([NaN],OnOffMerged,table(0),PropertiesMerged,[0],TimeScaleMerged,TimeRes);

       % ColorArg is 8 value colormap with info for allPoints, allMidPoints,
       % shortPoints, longPoints, allMeans, allMidMeans, shortMeans, longMeans
       % repeat value for each 4 times, it will update with every repeat
       ColorArg = [PalettePoints(i,:);PalettePoints(i,:);PalettePoints(i,:);PalettePoints(i,:);...
       PaletteMeans(i,:);PaletteMeans(i,:);PaletteMeans(i,:);PaletteMeans(i,:)];
       Selected = [PropertiesMerged.Type ~= 'BG'];
       YLimits = [min(0,min(MaxF(:))), max(2^Bits-1,max(MaxF(:)))];
        try
            YLimits = varargin{1};
        end  
       if MeansOnly == 1
            Fig1 = PlotMeansFraction(NormMerged,OnOffMerged,TimeScaleMerged,Selected,PropertiesMerged,Bits,ColorArg,Fig1,1,SelectedN{i},XLim, YLimits);
       else
            Fig2 = PlotMeans(NormMerged,OnOffMerged,TimeScaleMerged,Selected,PropertiesMerged,Bits,ColorArg,Fig2,0,SelectedN{i},XLim, YLimits);
       end
       
    %end
    if Heatmaps ~= 0
        MaxTime = 30;
        Selected = [PropertiesMerged.Type == 'ShortMidline' | PropertiesMerged.Type == 'LongMidline'];
        [NormAligned,TimeScaleAligned] = AlignFMatrixtoOnset(NormMerged,PropertiesMerged,TimeScaleMerged,MaxTime,TimeRes);
        Fig3 = PlotMeans(NormAligned,TimeScaleAligned,Selected,PropertiesMerged,Bits,ColorArg,Fig3,1,SelectedN{i},[0,MaxTime], YLimits);
        [FigH] = PlotHeatmaps(FigH,NormMerged,Selected,PropertiesMerged,TimeScaleMerged,SelectedN,TimeRes,XLim,i,Heatmaps);
    end
    
    
    end
    if strcmp(Selection,'') == 0; Selection = ['_',Selection];end
    if MeansOnly == 1
        print(Fig1,[ToSave,Selection,'_means.pdf'],'-fillpage', '-dpdf');
    else
        print(Fig2,[ToSave,Selection,'.pdf'],'-fillpage', '-dpdf');
    end
    

    if Heatmaps ~= 0
        print(Fig3,[ToSave,Selection,'_aligned.pdf'],'-fillpage', '-dpdf');
        print(FigH,[ToSave,Selection,'_heatmaps.pdf'],'-fillpage', '-dpdf');
    end
    close all
    %end
end