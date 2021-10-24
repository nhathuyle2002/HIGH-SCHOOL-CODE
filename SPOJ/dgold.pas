const   ginp='ss.inp';
        gout='ss.out';

type    mang=record t1,t2,cl:int64;end;

var     gi,go:text;
        n,m,mm,nn:longint;
        ans:int64;
        a,b:array[0..15] of int64;
        w1,w2:array[0..1000000] of mang;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n div 2 do readln(gi,a[i]);
        m:=n-n div 2;
        n:=n div 2;
        for i:=1 to m do readln(gi,b[i]);
end;

procedure sort(l,r:longint;var d:array of mang);
var     i,j:longint;
        tm,t:mang;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while (d[i].cl<t.cl) or ((d[i].cl=t.cl) and (d[i].t1<t.t1)) do inc(i);
                while (d[j].cl>t.cl) or ((d[j].cl=t.cl) and (d[j].t1>t.t1)) do dec(j);
                if i<=j then
                begin
                        tm:=d[i];d[i]:=d[j];d[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,d);sort(i,r,d);
end;

procedure create1(i:longint;sum1,sum2:int64);
begin
        if i>n then
        begin
                inc(nn);
                w1[nn].t1:=sum1;
                w1[nn].t2:=sum2;
                w1[nn].cl:=sum1-sum2;
                exit;
        end;
        create1(i+1,sum1,sum2);
        create1(i+1,sum1+a[i],sum2);
        create1(i+1,sum1,sum2+a[i]);
end;

procedure create2(i:longint;sum1,sum2:int64);
begin
        if i>m then
        begin
                inc(mm);
                w2[mm].t1:=sum1;
                w2[mm].t2:=sum2;
                w2[mm].cl:=sum1-sum2;
                exit;
        end;
        create2(i+1,sum1,sum2);
        create2(i+1,sum1+b[i],sum2);
        create2(i+1,sum1,sum2+b[i]);
end;

function bina_se(x:int64):longint;
var     dau,cuoi,mid:longint;
begin
        if x>w2[mm].cl then exit(-1);
        if x=w2[mm].cl then exit(mm);
        dau:=1;cuoi:=mm;
        while (dau<>cuoi) do
        begin
                mid:=(dau+cuoi) div 2;
                if w2[mid].cl<=x then dau:=mid+1 else cuoi:=mid;
        end;
        if w2[dau-1].cl=x then exit(dau-1);
        exit(-1);
end;

procedure process;
begin
        nn:=0;
        create1(1,0,0);
        mm:=0;
        create2(1,0,0);
        sort(1,nn,w1);
        sort(1,mm,w2);
end;

procedure output;
var     i,tm:longint;
begin
        ans:=0;
        for i:=1 to nn do
        begin
                tm:=bina_se(-w1[i].cl);
                if (tm<>-1) then
                        if ans<w1[i].t1+w2[tm].t1 then
                        ans:=w1[i].t1+w2[tm].t1;
        end;
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.















