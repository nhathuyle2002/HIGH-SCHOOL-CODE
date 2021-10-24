const   ginp='shn.inp';
        gout='shn.out';
        maxn=10000000;
        maxnnt=trunc(sqrt(maxn));

var     gi,go:text;
        ans:int64;
        s:array[0..maxn+1] of longint;
        nt:array[0..maxnnt] of longint;
        dpp:array[0..5*maxn] of longint;
        nnt,n:longint;

procedure sangnt;
var     i,j,tm:longint;
        d:array[0..maxnnt] of boolean;
begin
        tm:=trunc(sqrt(n));
        fillchar(d,sizeof(d),true);
        for i:=2 to trunc(sqrt(tm)) do
                if d[i] then
                begin
                        inc(nnt);
                        nt[nnt]:=i;
                        for j:=2 to tm div i do d[i*j]:=false;
                end;
        for i:=trunc(sqrt(tm))+1 to tm do
                if d[i] then
                begin
                        inc(nnt);
                        nt[nnt]:=i;
                end;
end;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,n);
end;

function sum(x:longint):longint;
var     i,tm,tmp:longint;
begin
        if x=1 then exit(2);
        i:=1;sum:=1;
        repeat
                tm:=1;tmp:=1;
                while x mod nt[i]=0 do
                begin
                        tm:=tm*nt[i];
                        tmp:=tmp+tm;
                        x:=x div nt[i];
                end;
                sum:=sum*tmp;
                inc(i);
        until (x<sqr(nt[i])) or (i>nnt);
        if x>1 then sum:=sum*(1+x);
end;

procedure sort(l,r:longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=s[random(r-l+1)+l];
        repeat
                while s[i]<t do inc(i);
                while s[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=s[i];s[i]:=s[j];s[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure process;
var     i:longint;
        //dem:int64;
begin
        for i:=1 to n do
        begin
                s[i]:=sum(i)-1-i;
                inc(dpp[s[i]]);
        end;
        {sort(1,n);
        dem:=0;
        for i:=n downto 1 do
                if s[i]=0 then
                begin
                        ans:=ans+dem*(dem-1) div 2;
                        exit;
                end else
                if s[i]<>s[i+1] then
                begin
                        ans:=ans+dem*(dem-1) div 2;
                        dem:=1;
                end else inc(dem);}
        for i:=1 to 5*n do
                if dpp[i]>=2 then ans:=ans+int64(dpp[i])*(dpp[i]-1) div 2;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        sangnt;
        process;
        output;
end.







