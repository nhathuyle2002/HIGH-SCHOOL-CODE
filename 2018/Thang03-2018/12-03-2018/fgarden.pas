const   ginp='fgarden.inp';
        gout='fgarden.out';

var     gi,go:text;
        n,mab,mib,maf,mif,ans:longint;
        t:int64;
        a,f:array[0..301] of int64;
        ma,mi:array[0..301] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,t);
        for i:=1 to n do read(gi,a[i]);
end;

procedure process;
var     i,j:longint;
begin
        for i:=1 to n do
                for j:=f[i-1] to i do
                begin
                        while (mif<mib) and (mi[mif]<j) do inc(mif);
                        while (maf<mab) and (ma[maf]<j) do inc(maf);
                        while (mif<=mib) and (a[i]<=a[mi[mib]]) do dec(mib);
                        while (maf<=mab) and (a[i]>=a[ma[mab]]) do dec(mab);
                        inc(mib);mi[mib]:=i;
                        inc(mab);ma[mab]:=i;
                        if a[ma[maf]]-a[mi[mif]]<=t then
                        begin
                                f[i]:=j;
                                break;
                        end;
                end;
        ans:=0;
        for i:=1 to n do
                if ans<i-f[i]+1 then ans:=i-f[i]+1;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
