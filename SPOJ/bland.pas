const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e9)+10;

type    save=record mi,ma:longint;end;
        deque=record g,v:longint;end;

var     gi,go:text;
        m,n,maxk,l1,r1,l2,r2,res:longint;
        q1,q2:array[0..301] of deque;
        a,mh,mc:array[0..301,0..301] of longint;
        h,c:array[0..301,0..301,0..301] of save;
        fh1,fh2,fc1,fc2:array[0..301] of longint;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure input;
var     i,j,k:longint;
begin
        readln(gi,m,n,maxk);
        for i:=1 to m do
        begin
                for j:=1 to n do read(gi,a[i,j]);
                readln(gi);
        end;
        for i:=1 to m do
                for k:=0 to n-1 do
                        for j:=1 to n-k do
                        if k=0 then
                        begin
                                h[i,j,j].mi:=a[i,j];
                                h[i,j,j].ma:=a[i,j];
                        end else
                        begin
                                h[i,j,j+k].mi:=min(a[i,j],h[i,j+1,j+k].mi);
                                h[i,j,j+k].ma:=max(a[i,j],h[i,j+1,j+k].ma);
                        end;
        for j:=1 to n do
                for k:=0 to m-1 do
                        for i:=1 to m-k do
                        if k=0 then
                        begin
                                c[j,i,i].mi:=a[i,j];
                                c[j,i,i].ma:=a[i,j];
                        end else
                        begin
                                c[j,i,i+k].mi:=min(a[i,j],c[j,i+1,i+k].mi);
                                c[j,i,i+k].ma:=max(a[i,j],c[j,i+1,i+k].ma);
                        end;
end;

procedure push(x:save;v:longint);
begin
        while (l1<=r1) and (q1[r1].g>=x.mi) do dec(r1);
        inc(r1);q1[r1].g:=x.mi;q1[r1].v:=v;
        while (l2<=r2) and (q2[r2].g<=x.ma) do dec(r2);
        inc(r2);q2[r2].g:=x.ma;q2[r2].v:=v;
end;

procedure pop(v:longint);
begin
        while (l1<=r1) and (q1[l1].v<=v) do inc(l1);
        while (l2<=r2) and (q2[l2].v<=v) do inc(l2);
end;

procedure process;
var     i1,i2,j1,j2:longint;
begin
        for i1:=1 to m do
                for i2:=i1 to m do
                begin
                        l1:=1;r1:=1;l2:=1;r2:=1;
                        q1[1].g:=oo;q2[1].g:=-oo;
                        j1:=1;j2:=0;
                        repeat
                                if j2<j1 then
                                begin
                                        inc(j2);
                                        push(c[j2,i1,i2],j2);
                                end;
                                if q2[l2].g-q1[l1].g<=maxk then
                                begin
                                        mh[i1,i2]:=max(mh[i1,i2],j2-j1+1);
                                        inc(j2);
                                        push(c[j2,i1,i2],j2);
                                end else
                                begin
                                        pop(j1);inc(j1);
                                end;
                        until (j1>n) or (j2>n);
                end;
        for j1:=1 to n do
                for j2:=j1 to n do
                begin
                        l1:=1;r1:=1;l2:=1;r2:=1;
                        q1[1].g:=oo;q2[1].g:=-oo;
                        i1:=1;i2:=0;
                        repeat
                                if i2<i1 then
                                begin
                                        inc(i2);
                                        push(h[i2,j1,j2],i2);
                                end;
                                if q2[l2].g-q1[l1].g<=maxk then
                                begin
                                        mc[j1,j2]:=max(mc[j1,j2],i2-i1+1);
                                        inc(i2);
                                        push(h[i2,j1,j2],i2);
                                end else
                                begin
                                        pop(i1);inc(i1);
                                end;
                        until (i1>m) or (i2>m);
                end;
end;

procedure output;
var     i1,i2,j1,j2,i,j:longint;
begin
        for i1:=1 to m do
                for i2:=i1 to m do
                begin
                        fh1[i2]:=max(fh1[i2],mh[i1,i2]*(i2-i1+1));
                        fh2[i1]:=max(fh2[i1],mh[i1,i2]*(i2-i1+1));
                end;
        for i:=1 to m do
                fh1[i]:=max(fh1[i],fh1[i-1]);
        for i:=m downto 1 do
                fh2[i]:=max(fh2[i],fh2[i+1]);
        for j1:=1 to n do
                for j2:=j1 to n do
                begin
                        fc1[j2]:=max(fc1[j2],mc[j1,j2]*(j2-j1+1));
                        fc2[j1]:=max(fc2[j1],mc[j1,j2]*(j2-j1+1));
                end;
        for j:=1 to n do
                fc1[j]:=max(fc1[j],fc1[j-1]);
        for j:=n downto 1 do
                fc2[j]:=max(fc2[j],fc2[j+1]);
        res:=0;
        for i:=1 to m-1 do
                res:=max(res,fh1[i]+fh2[i+1]);
        for j:=1 to n-1 do
                res:=max(res,fc1[j]+fc2[j+1]);
        res:=max(res,fh1[m]);res:=max(res,fh2[1]);
        res:=max(res,fc1[n]);res:=max(res,fc2[1]);
        write(go,res);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        output;
        close(gi);close(go);
end.















