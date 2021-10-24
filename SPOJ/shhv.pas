const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n:longint;
        ans,p:int64;
        a:array[0..13] of longint;
        gt:array[0..13] of int64;
        d:array[0..13] of boolean;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        while not seekeoln(gi) do
        begin
                inc(n);
                read(gi,a[n]);
        end;
        readln(gi);
        read(gi,p);
end;

procedure try1(i:longint);
var     j,dem:longint;
begin
        if i=n+1 then exit;
        dem:=0;
        for j:=1 to n do
        begin
                if d[j] then inc(dem);
                if j=a[i] then break;
        end;
        d[j]:=false;
        ans:=ans+(dem-1)*gt[n-i];
        try1(i+1);
end;

procedure try2(i:longint);
var     j,dem:longint;
begin
        if i=0 then exit;
        dem:=0;
        for j:=1 to n do
        begin
                if d[j] then inc(dem);
                if p-ans<=dem*gt[i-1] then break;
        end;
        d[j]:=false;a[n-i+1]:=j;
        ans:=ans+(dem-1)*gt[i-1];
        try2(i-1);
end;

procedure process;
var     i:longint;
begin
        gt[0]:=1;
        for i:=1 to n do
                gt[i]:=gt[i-1]*i;
        fillchar(d,sizeof(d),true);
        ans:=0;try1(1);writeln(go,ans+1);
        fillchar(d,sizeof(d),true);
        ans:=0;try2(n);
        for i:=1 to n do write(go,a[i],' ');
end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
