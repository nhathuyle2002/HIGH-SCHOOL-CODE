const   ginp='dacsan.inp';
        gout='dacsan.out';
        oo=trunc(1e9);

var     n,maxk,maxs:longint;
        f:array[0..21,0..21,0..2010] of longint;
        a:array[0..21,0..21] of longint;

procedure enter;
var     i,k:longint;
begin
        readln(maxk,n,maxs);
        for i:=1 to n do
        begin
                for k:=1 to maxk do read(a[i,k]);
                a[i,maxk+1]:=oo;
                readln;
        end;
end;

procedure process;
var     i,k,s,ii:longint;
        ok:boolean;
begin
        for i:=1 to n do f[maxk+1,i,0]:=1;
        for k:=maxk downto 1 do
        for i:=1 to n do
        for s:=0 to maxs do
                if s-a[i,k]>=0 then
                for ii:=1 to n do
                        if (f[k+1,ii,s-a[i,k]]>0) and (a[ii,k+1]>=a[i,k])
                        and ((f[k,i,s]=0) or (a[f[k,i,s],k+1]>a[ii,k+1])) then f[k,i,s]:=ii;
        ok:=false;
        for i:=1 to n do
                if f[1,i,maxs]>0 then ok:=true;
        if not ok then write('NO') else
        begin
                writeln('YES');
                i:=0;
                for ii:=1 to n do
                        if (f[1,ii,maxs]>0) and ((i=0) or (a[i,1]>a[ii,1])) then i:=ii;
                k:=1;s:=maxs;
                repeat
                        ii:=f[k,i,s];
                        s:=s-a[i,k];
                        write(a[i,k],' ');
                        i:=ii;
                        inc(k);
                until k>maxk;
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
