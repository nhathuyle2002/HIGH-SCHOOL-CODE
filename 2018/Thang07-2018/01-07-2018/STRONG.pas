const   fi='STRONG.INP';
        fo='STRONG.OUT';
        dx:array[1..4] of integer=(1,0,-1,0);
        dy:array[1..4] of integer=(0,-1,0,1);

var     a:Array[1..501] of ANSIstring;
        n,k,i,ct:longint;
        id,sumx:array[-1..501,-1..501] of longint;
        sl:array[0..501*501] of longint;
        dd:array[0..501,0..501*501] of longint;
        res:array[0..501] of longint;

procedure dfs(x,y:longint);
var     xt,yt,i:longint;
begin
        id[x,y]:=ct;
        inc(sl[ct]);
        for i:=1 to 4 do
        begin
                xt:=x+dx[i]; yt:=y+dy[i];
                if (id[xt,yt]=0) and (a[xt,yt]='.')
                then dfs(xt,yt);
        end;
end;
procedure init;
var i,j:longint;
begin
        for i:=1 to n do
        for j:=1 to n do
        begin
                sumx[i,j]:=sumx[i-1,j]+sumx[i,j-1]-sumx[i-1,j-1];
                if a[i,j]<>'.' then inc(sumx[i,j]);
        end;
        for i:=0 to n+1 do
        begin
                id[i,0]:=-1; id[i,n+1]:=-1;
                id[0,i]:=-1; id[n+1,i]:=-1;
        end;
        for i:=1 to n do
        for j:=1 to n do if (a[i,j]='.') and (id[i,j]=0) then
        begin
                inc(ct);
                dfs(i,j);
        end;
end;

procedure push(x,y,col:longint);
begin
        if id[x,y]<=0 then exit;
        inc(dd[col,id[x,y]]);
        if dd[col,id[x,y]]=1 then res[col]:=res[col]+sl[id[x,y]];
end;

procedure pop(x,y,col:longint);
begin
        if id[x,y]<=0 then exit;
        dec(dd[col,id[x,y]]);
        if dd[col,id[x,y]]=0 then dec(Res[col],sl[id[x,y]]);
end;

procedure main;
var i,j,l,kq,tmp:longint;
begin
        for i:=1 to n-k+1 do
        begin
                for j:=1 to k do
                for l:=i-1 to i+k do push(j,l,i);
                pop(k,i-1,i); pop(k,i+k,i);
        end;
        kq:=0;
        for i:=1 to n-k+1 do
        for j:=1 to n-k+1 do
        begin
                for l:=0 to k-1 do
                begin
                        pop(i-2,j+L,j);
                        push(i+k,j+l,j);
                end;
                push(i+k-1,j-1,j); push(i+k-1,j+k,j);
                pop(i-1,j-1,j); pop(i-1,j+k,j);
                tmp:=sumx[i+k-1,j+k-1]-sumx[i+k-1,j-1]-sumx[i-1,j+k-1]+sumx[i-1,j-1];
                if tmp+res[j]>kq then kq:=tmp+res[j];
        end;
        write(kq);
end;

begin
        assign(input,fi);  assign(output,fo);
        reset(input);      rewrite(output);
        readln(n,k);
        for i:=1 to n do readln(a[i]);
        init;
        main;
        close(input);      close(output);
end.
