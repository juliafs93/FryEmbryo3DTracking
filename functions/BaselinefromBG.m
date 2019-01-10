function[Baseline, baseline,MaxFBG, BG, BGLabels] = BaselinefromBG(MaxF,Labels, Smooth,minOn)
    %% define baseline
    MeanBaseline = nanmean(MaxF,2);
    %plot(MeanBaseline); hold on
    LFit = fitlm([1:length(MeanBaseline)],MeanBaseline);
    baseline = LFit.Coefficients.Estimate'
    Baseline = [1:length(MeanBaseline)]*baseline(2) + baseline(1);
    %plot (Baseline);
    % fit to line
    % save baseline
    %% get background and redefine baseline
    %Smooth = 3;
    MedFilt = medfilt1(MaxF,Smooth,[],1,'includenan','zeropad');
    MedFilt(MedFilt==0) = NaN;
    %plot(MedFilt); hold on
    %plot (Baseline);
    % onoff
    %minOn = 5;
    OnOff = MedFilt > [Baseline'.*1.2];
    %plot(MaxF.*OnOff);

    % get background
    %OnOffString = join(string(double([(~isnan(MaxF))])),'',1);
    OnOffString = join(string(double(OnOff)),'',1);
    BG = cellfun(@(x) isempty(x), strfind(OnOffString,repmat('1',1,minOn)));
    BGLabels = Labels (BG);
    %%
    % redefine baseline
    MaxFBG = MaxF(:,BG);
    MeanBaseline = nanmean(MaxFBG,2);
    %plot(MeanBaseline); hold on
    LFit = fitlm([1:length(MeanBaseline)],MeanBaseline);
    baseline = LFit.Coefficients.Estimate'
    Baseline = [1:length(MeanBaseline)]*baseline(2) + baseline(1);
    %plot (Baseline);
end