const   ginp='kdel.inp';
        gout='kdel.out';
        maxn=650000;

var     gi,go:text;
        a,q:array[0..300000] of longint;
        d:array[0..300000] of boolean;
        n,k,ntm,l,r:longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,k);
end;

procedure xuli(x:longint);
var     s:string;
        i:longint;
begin
        str(x,s);
        for i:=1 to length(s) do
        begin
                inc(ntm);
                a[ntm]:=ord(s[i])-48;
        end;
end;

procedure sangnt;
var     i,j,dem:longint;
        dd:array[0..maxn] of boolean;
begin
        dem:=0;
        fillchar(dd,sizeof(dd),true);
        dd[1]:=false;
        for i:=2 to trunc(sqrt(maxn)) do
                if dd[i] then
                begin
                        if dem=n then exit;
                        for j:=2 to maxn div i do dd[i*j]:=false;
                        inc(dem);
                        xuli(i);
                end;
        for i:=trunc(sqrt(maxn))+1 to maxn do
                if dd[i] then
                begin
                        if dem=n then exit;
                        inc(dem);
                        xuli(i);
                end;
end;

procedure pop(i:longint);
begin
        while (l<=r) and (q[l]<i) do inc(l);
end;

procedure push(i:longint);
begin
        while (l<=r) and (a[q[r]]<a[i]) do dec(r);
        inc(r);
        q[r]:=i;
end;

procedure process;
var     i,j:longint;
begin
        n:=ntm;
        if n=k then exit;
        fillchar(d,sizeof(d),true);
        if k=0 then exit;
        l:=0;r:=0;
        for i:=1 to k do push(i);
        while (k>0) and (i<n) do
        begin
                inc(i);
                pop(i-k);push(i);
                for j:=q[l]-1 downto i-k do d[j]:=false;
                k:=k-((q[l]-1)-(i-k)+1);
        end;
        for i:=1 to k do d[n-i+1]:=false;
end;

procedure output;
var     i:longint;
begin
        if n=k then write(go,0) else
        for i:=1 to n do
                if d[i] then write(go,a[i]);
        close(gi);close(go);
end;

begin
        input;
        sangnt;
        process;
        output;
end.