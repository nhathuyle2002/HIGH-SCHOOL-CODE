const   ginp='ss.inp';
        gout='ss.out';
        maxn=30000;

var     gi,go:text;
        n,p,nnt,ans:longint;
        nt,d,dd:array[0..maxn] of longint;

procedure sangnt;
var     i,j:longint;
        dd:array[0..maxn] of boolean;
begin
        fillchar(dd,sizeof(dd),true);
        for i:=2 to maxn do
                if dd[i] then
                begin
                        inc(nnt);
                        nt[nnt]:=i;
                        for j:=2 to maxn div i do dd[i*j]:=false;
                end;
end;

procedure ptnt(x:longint);
var     i:longint;
begin
        i:=1;
        while nt[i]<=sqrt(x) do
                if x mod nt[i]=0 then
                begin
                        inc(d[nt[i]]);
                        x:=x div nt[i];
                end else inc(i);
        if x<>1 then inc(d[x]);
end;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,p);
end;

procedure process;
var     i,tm:longint;
begin
        ans:=maxlongint;
        for i:=2 to n do ptnt(i);
        dd:=d;fillchar(d,sizeof(d),0);
        ptnt(p);
        for i:=2 to maxn do
                if d[i]<>0 then
                begin
                        tm:=dd[i] div d[i];
                        if tm<ans then ans:=tm;
                end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        sangnt;
        input;
        process;
        output;
end.
