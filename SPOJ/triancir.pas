const   ginp='ss.inp';
        gout='ss.out';
        goc=180000;
        maxg=360000;

var     gi,go:text;
        n:longint;
        d,s:array[-1..maxg+1] of longint;

procedure input;
var     i,x,j:longint;
        ss:string;
begin
        fillchar(d,sizeof(d),0);
        fillchar(s,sizeof(s),0);
        for i:=1 to n do
        begin
                readln(gi,ss);x:=0;
                for j:=1 to length(ss) do
                        if ss[j]<>'.' then x:=x*10+ord(ss[j])-48;
                inc(d[x]);
        end;
        for i:=0 to maxg-1 do
                s[i]:=s[i-1]+d[i];
end;

procedure process;
var     i:longint;
        ans,tm1,tm2,tm3,tmp:int64;
begin
        ans:=n*(n-1)*(n-2) div 6;
        for i:=0 to maxg-1 do
                begin
                        if i<goc then tm1:=s[i+goc-1]-s[i] else tm1:=s[maxg-1]-s[i]+s[i-goc-1];
                        if i<goc then
                        begin
                                tm2:=tm1*d[i]*d[i+goc];
                                tmp:=d[i]+d[i+goc];
                                if tmp>=3 then tm2:=tm2+tmp*(tmp-1)*(tmp-2) div 6;
                        end
                        else tm2:=tm1*d[i]*d[i-goc];
                        if d[i]>=2 then tm3:=tm1*d[i]*(d[i]-1) div 2 else tm3:=0;
                        if tm1>=1 then tm1:=d[i]*tm1*(tm1-1) div 2;
                        ans:=ans-tm1-tm2-tm3;
                end;
        writeln(go,ans);
end;

procedure main;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        while not eof(gi) do
        begin
                readln(gi,n);
                if n=0 then break;
                input;
                process;
        end;
        close(gi);close(go);
end;

begin
        main;
end.
