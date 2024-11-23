function DetectorP( record )
  % Summary of this function and detailed explanation goes here

  % First convert the record into matlab (creates recordm.mat):
  % wfdb2mat -r record

  cmd = sprintf('wfdb2mat -r %s', record);
  system(cmd);
  fileName = sprintf('%sm.mat', record);
  t=cputime();
  %m=7;
  %normalizeConst=32;
  %idx = QRSDetect(fileName,m, normalizeConst);
  M = 7;
  window_size = 38;
  alpha = 0.05;
  gamma = 0.2;
  [idx P] = QRSDetectA(fileName, M, window_size, alpha, gamma);
  P %<-----------------------
  fprintf('Running time: %f\n', cputime() - t);
  asciName = sprintf('%s.asc',record);
  fid = fopen(asciName, 'wt');
  for i=1:size(idx,2)
      fprintf(fid,'0:00:00.00 %d N 0 0 0\n', idx(1,i) );
  end
  fclose(fid);

  cmd = sprintf('wrann -r %s -a qrs < %s.asc', record, record);
  system(cmd);

  cmd = sprintf('bxb -r %s -a atr qrs', record);
  system(cmd);

  % Now convert the .asc text output to binary WFDB format:
  % wrann -r record -a qrs <record.asc
  % And evaluate against reference annotations (atr) using bxb:
  % bxb -r record -a atr qrs
end