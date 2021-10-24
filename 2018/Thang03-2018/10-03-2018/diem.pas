const   ginp='diem.inp';
        gout='diem.out';
        di:array[1..4] of longint= (-1,0,0,1);
        dj:array[1..4] of longint= (0,-1,1,0);

type    point=record x,y:longint;end;

var     gi,go:text;
        n,w,h:longint;
        a:array[0..1000] of point;
        hg:array[0..1000] of longint;
        c,d:array[-1..1000,-1..1000] of boolean;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,w,h);
        for i:=1 to n do readln(gi,a[i].x,a[i].y);
end;

procedure dd1(i,dd,cc:longint);
var     j:longint;
begin
        for j:=dd to cc do c[i,j]:=true;
end;

procedure dd2(j,dd,cc:longint);
var     i:longint;
begin
        for i:=dd to cc do c[i,j]:=true;
end;

procedure dfs(i,j:longint);
var     k,i0,j0:longint;
begin
        d[i,j]:=false;
        for k:=1 to 4 do
        begin
                i0:=i+di[k];
                j0:=j+dj[k];
                if (i0>=0) and (j0>=0) and (i0<=h+1) and (j0<=w+1) and (d[i0,j0]) then dfs(i0,j0);
        end;
end;

procedure process;
var     i,tmp,j:longint;
begin
        fillchar(c,sizeof(c),false);
        a[n+1]:=a[1];a[n+2]:=a[2];
        for i:=1 to n do
                if (a[i].x=a[i+1].x) then
                begin
                        if a[i].y<a[i+1].y then hg[i]:=1
                        else hg[i]:=4;
                end
                else
                begin
                        if a[i].x<a[i+1].x then hg[i]:=3
                        else hg[i]:=2;
                end;
        for i:=3 to n+2 do
        begin
                if ((hg[i-2]=1) and (hg[i-1]=2)) or ((hg[i-2]=4) and (hg[i-1]=2))
                                                                then dd1(a[i].y,a[i].x+1,a[i-1].x);
                if ((hg[i-2]=1) and (hg[i-1]=3)) or ((hg[i-2]=4) and (hg[i-1]=3))
                                                                then dd1(a[i].y+1,a[i-1].x+1,a[i].x);
                if ((hg[i-2]=2) and (hg[i-1]=1)) or ((hg[i-2]=3) and (hg[i-1]=1))
                                                                then dd2(a[i].x,a[i-1].y+1,a[i].y);
                if ((hg[i-2]=2) and (hg[i-1]=4)) or ((hg[i-2]=3) and (hg[i-1]=4))
                                                                then dd2(a[i].x+1,a[i].y+1,a[i-1].y);
        end;
        fillchar(d,sizeof(d),true);
        for i:=1 to h do
                for j:=1 to w do
                        if c[i,j] then d[i,j]:=false;
        dfs(0,0);
end;

procedure output;
var     i,j:longint;
begin
        for i:=h downto 1 do
        begin
                for j:=1 to w do
                        if (c[i,j]) or (d[i,j]) then write(go,'#') else write(go,'.');
                writeln(go);
        end;
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.