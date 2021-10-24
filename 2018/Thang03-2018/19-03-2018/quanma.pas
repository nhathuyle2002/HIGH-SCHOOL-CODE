const   ginp='quanma.inp';
        gout='quanma.out';
        di:array[1..8] of longint= (-2,-2,-1,-1,1,1,2,2);
        dj:array[1..8] of longint= (-1,1,-2,2,-2,2,-1,1);

var     gi,go:text;
        x1,y1,x2,y2,n,m,ans:longint;
        d:array[0..1001,0..1001] of boolean;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        readln(gi,x1,y1);
        read(gi,x2,y2);
end;

function cdt(x,y:longint):boolean;
begin
        if (x<1) or (y<1) or (x>n) or (y>m) then exit(false);
        if d[x,y]=false then exit(false);
        exit(true);
end;

procedure bfs;
var     qi,qj,f:array[0..1000001] of longint;
        l,k,r,x0,y0:longint;
begin
        ans:=0;
        if (x1=x2) and (y1=y2) then exit;
        fillchar(d,sizeof(d),true);
        d[x1,y1]:=true;
        f[1]:=0;
        qi[1]:=x1;qj[1]:=y1;
        l:=1;r:=1;
        repeat
                for k:=1 to 8 do
                begin
                        x0:=di[k]+qi[l];
                        y0:=dj[k]+qj[l];
                        if cdt(x0,y0) then
                        begin
                                inc(r);
                                d[x0,y0]:=false;
                                qi[r]:=x0;
                                qj[r]:=y0;
                                f[r]:=f[l]+1;
                                if (x0=x2) and (y0=y2) then
                                begin
                                        ans:=f[r];
                                        exit;
                                end;
                        end;
                end;
                inc(l);
        until l>r;
end;

procedure output;
begin
        if d[x2,y2] then write(go,-1) else write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        bfs;
        output;
end.