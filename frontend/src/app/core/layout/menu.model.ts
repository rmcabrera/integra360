import { Svc } from '../config/app-config';

/** A node of the sidebar. A section is a top-level node with children. */
export interface MenuNode {
  label: string;
  /** Absolute router path. Leaf nodes have one; grouping nodes may omit it. */
  route?: string;
  /** Owning backend service, for context/labels. */
  svc?: Svc | 'gerencial';
  children?: MenuNode[];
}
