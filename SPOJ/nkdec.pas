const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        m,n,p,cs:longint;
        a:array[0..201] of string;
        fh,fc,vt:array[0..201] of longint;
        ou:array[0..201,0..201] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,m,n);
        for i:=1 to m do readln(gi,a[i]);
end;

procedure process;
var     i,j,tm:longint;
begin
        fillchar(fh,sizeof(fh),0);
        fillchar(fc,sizeof(fc),0);
        for i:=1 to m do
                for j:=1 to n do
                begin
                        tm:=ord(a[i,j])-48;
                        fh[i]:=fh[i]+tm;
                        fc[j]:=fc[j]+tm;
                end;
        p:=0;
        cs:=1;
        for i:=1 to m do
                if p<fh[i] then p:=fh[i];
        for j:=1 to n do
                if p<fc[j] then
                begin
                        p:=fc[j];
                        cs:=2;
                end;
end;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure sort(l,r:longint;d:array of longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i]<t do inc(i);
                while d[j]>t do dec(j);
                if i<=j then
                begin
                        swap(d[i],d[j]);
                        swap(vt[i],vt[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,d);sort(i,r,d);
end;

procedure swapd(var d:array of longint);
var     i,tm:longint;
begin
        tm:=d[p];
        for i:=p downto 2 do d[i]:=d[i-1];
        d[1]:=tm;
end;

procedure output;
var     i,j,k:longint;
        dh,dc:array[0..201,0..201] of boolean;
        ok:boolean;
        b:array[0..201] of longint;
begin
        writeln(go,p);
        for i:=1 to p do b[i]:=i;
        fillchar(dh,sizeof(dh),true);
        fillchar(dc,sizeof(dc),true);
        if cs=1 then
        begin
                for i:=1 to m do vt[i]:=i;
                sort(1,m,fh);
                for i:=m downto 1 do
                        for j:=1 to n do
                        if a[vt[i],j]='0' then ou[vt[i],j]:=0 else
                        begin
                                for k:=1 to p do
                                        if (dh[vt[i],b[k]]) and (dc[j,b[k]]) then break;
                                dh[vt[i],b[k]]:=false;dc[j,b[k]]:=false;
                                ou[vt[i],j]:=b[k];
                                swapd(b);
                        end;
        end else
        begin
                for j:=1 to n do vt[j]:=j;
                sort(1,n,fc);
                for j:=n downto 1 do
                        for i:=1 to m do
                        if a[i,vt[j]]='0' then ou[i,vt[j]]:=0 else
                        begin
                                for k:=1 to p do
                                        if (dh[i,b[k]]) and (dc[vt[j],b[k]]) then break;
                                dh[i,b[k]]:=false;dc[vt[j],b[k]]:=false;
                                ou[i,vt[j]]:=b[k];
                                swapd(b);
                        end;
        end;
        for i:=1 to m do
        begin
                for j:=1 to n do write(go,ou[i,j],' ');
                writeln(go);
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        output;
        close(gi);close(go);
end.
