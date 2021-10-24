uses math;
const
  FINP          =       'ss.inp';
  FOUT          =       'ss.out';
  MAXN          =       10111;
  MAXK          =       55;
  base          =       15111992;

var
  f1,f2         :       text;
  n,k,s         :       longint;
  bit,f         :       array[1..MAXN,1..MAXK] of longint;
  a,c,ind       :       array[1..MAXN] of longint;

procedure openF;
    begin
      assign(f1,FINP); reset(f1);
      assign(f2,FOUT); rewrite(f2);
    end;

procedure closeF;
    begin
      close(f1);
      close(f2);
    end;

procedure inp;
    var
      i:longint;
    begin
      read(f1,n,k);
      for i:=1 to n do read(f1,a[i]);
    end;

procedure swap(var a,b:longint); inline;
    var
      tmp:longint;
    begin
      tmp:=a; a:=b; b:=tmp;
    end;

procedure sort(l,r:longint);
    var
      i,j,mid:longint;
    begin
      i:=l; j:=r; mid:=c[l+random(r-l+1)];
      repeat
        while c[i]<mid do inc(i);
        while c[j]>mid do dec(j);
        if i<=j then
          begin
            swap(c[i],c[j]);
            swap(ind[i],ind[j]);
            inc(i); dec(j);
          end;
      until i>j;
      if i<r then sort(i,r);
      if l<j then sort(l,j);
    end;

procedure RR;
    var
      i:longint;
    begin
      for i:=1 to n do
        begin
          c[i]:=a[i];
          ind[i]:=i;
        end;
      sort(1,n);
      s:=1; a[ind[1]]:=1;
      for i:=2 to n do
        begin
          if c[i]>c[s] then
            begin
              inc(s);
              c[s]:=c[i];
            end;
          a[ind[i]]:=s;
        end;
    end;

function get(u,x:longint):longint;
    var
      res,v:longint;
    begin
      if u<=0 then exit(0);
      v:=u-u and (-u);
      res:=get(v,x)+bit[u,x];
      if res>base then dec(res,base);
      exit(res);
    end;

procedure update(u,x,k:longint);
    var
      v:longint;
    begin
      if u>s then exit;
      inc(bit[u,x],k);
      if bit[u,x]>base then dec(bit[u,x],base);
      v:=u+u and (-u);
      update(v,x,k);
    end;

procedure solve;
    var
      u,i,l:longint;
    begin
      for i:=1 to n do
        begin
          if f[a[i],1]=0 then
            begin
              f[a[i],1]:=1;
              update(a[i],1,+1);
            end;
          for l:=2 to k do
            begin
              u:=get(a[i]-1,l-1);
              update(a[i],l,u-f[a[i],l]);
              f[a[i],l]:=u;
            end;
        end;
      writeln(f2,get(s,k));
    end;

begin
  openF;
  inp;
  RR;
  solve;
  closeF;
end.
