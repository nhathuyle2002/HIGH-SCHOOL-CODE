const   ginp='ss.inp';
        gout='ss.out';

var i,j,k,m,n:longint;
      b,c,s,t:extended;
        gi,go:text;
  begin
  assign(gi,ginp);assign(go,gout);
  reset(gi);rewrite(go);
    readln(gi,n,c);
    dec(n);
    m:=trunc(sqrt(c));
    if m>=n then
      begin
        writeln(go,'0.00');
        exit;
      end;
    if c/m<=m+1 then
      begin
        b:=m+c/m;
        s:=n*n-b*n+c;
      end
    else s:=1e100;
    inc(m);
    if c/m>=m-1 then
      begin
        b:=m+c/m;
        t:=n*n-b*n+c;
      end
    else t:=1e100;
    if s<t then writeln(go,s:0:2)
      else writeln(go,t:0:2);
      close(gi);close(go);
  end.
