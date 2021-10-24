const   ginp='mk.inp';
        gout='mk.out';
        base=311;
        kk=round(1e9)+7;

var     n,t1,t2:longint;
        res:int64;
        a:array[0..20010] of string[10];
        h:array[0..20010,0..11] of int64;
        pow:array[0..11] of int64;
        b,c:array[0..200010] of int64;

function sosanh(x,y:string):boolean;
var     i:longint;
begin
        if length(x)<length(y) then exit(true);
        if length(y)<length(x) then exit(false);
        for i:=1 to length(x) do
                if x[i]<y[i] then exit(true) else
                if x[i]>y[i] then exit(false);
        exit(false);
end;

procedure sortstr(l,r:longint); inline;
var     i,j:longint;
        t,tm:string[10];
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while sosanh(a[i],t) do inc(i);
                while sosanh(t,a[j]) do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sortstr(l,j);sortstr(i,r);
end;

procedure sort(l,r:longint; var o:array of int64); inline;
var     i,j:longint;
        t,tm:int64;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=o[random(r-l+1)+l];
        repeat
                while o[i]<t do inc(i);
                while o[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=o[i];o[i]:=o[j];o[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,o);sort(i,r,o);
end;

procedure enter;
var     i,j:longint;
begin
        readln(n);
        for i:=1 to n do readln(a[i]);
        sortstr(1,n);
        for i:=1 to n do
                for j:=1 to length(a[i]) do
                        h[i,j]:=(h[i,j-1]*base+ord(a[i,j])) mod kk;
        pow[0]:=1;
        for i:=1 to 10 do pow[i]:=(pow[i-1]*base) mod kk;
end;

procedure push(var top:longint;var aa:array of int64;x:int64); inline;
begin
        inc(top);aa[top]:=x;
end;

procedure process;
var     i,l,ii,j,tt2:longint;
        d:array[0..11] of int64;
        db,dc:array[0..200010] of longint;
begin
        res:=0;
        b[0]:=0;c[0]:=0;
        i:=1;
        for l:=1 to 10 do
        begin
                t1:=0;
                while (i<=n) and (length(a[i])=l) do
                begin
                        push(t1,b,h[i,l]);
                        inc(i);
                end;
                if t1=0 then continue;
                sort(1,t1,b);
                ii:=0;
                for j:=1 to t1 do
                        if b[j]>b[ii] then
                        begin
                                inc(ii);db[ii]:=1;
                                b[ii]:=b[j];
                        end
                        else    inc(db[ii]);
                t1:=ii;
                for j:=1 to t1 do res:=res+int64(db[j])*(db[j]-1);
                t2:=0;
                for ii:=i to n do
                begin
                        tt2:=0;
                        for j:=l to length(a[ii]) do
                                push(tt2,d,(h[ii,j]-h[ii,j-l]*pow[l]+kk*kk) mod kk);
                        sort(1,tt2,d);
                        push(t2,c,d[1]);
                        for j:=2 to tt2 do
                                if d[j]>d[j-1] then push(t2,c,d[j]);
                end;
                if t2=0 then continue;
                sort(1,t2,c);
                ii:=0;
                for j:=1 to t2 do
                        if c[j]>c[ii] then
                        begin
                                inc(ii);dc[ii]:=1;
                                c[ii]:=c[j];
                        end
                        else    inc(dc[ii]);
                t2:=ii;
                ii:=1;
                for j:=1 to t1 do
                begin
                        while (c[ii]<b[j]) and (ii<=t2) do inc(ii);
                        if (ii<=t2) and (c[ii]=b[j]) then res:=res+int64(db[j])*dc[ii];
                end;
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
